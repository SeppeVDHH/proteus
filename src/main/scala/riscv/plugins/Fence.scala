package riscv.plugins

import riscv._

import spinal.core._
import spinal.lib._
import riscv.plugins.scheduling.dynamic.ReorderBuffer


class Fence() extends Plugin[Pipeline] with FenceService {
  object Opcodes {
    val FENCE = M"-------------------------0001111"
  }

  object Data {
    object FENCE extends PipelineData(Bool())
  }

  override def setup(): Unit = {
    pipeline.service[DecoderService].configure { config =>
      config.addDefault(
        Map(
          Data.FENCE -> False
        )
      )

      config.addDecoding(
        Opcodes.FENCE,
        InstructionType.I,
        Map(
          Data.FENCE -> True,
          pipeline.data.RD_TYPE -> RegisterType.NONE
        )
      )
    }
  }

  override def build(): Unit = {
    for (stage <- pipeline.stages) {
      import stage._
      if (stage != pipeline.fetchStage) {
        stage plug new Area {
          stage.output(Data.FENCE)
        }
      }
    }
  }


  override def isFence(stage: Stage): Bool = {
    stage.output(Data.FENCE)
  }
}
